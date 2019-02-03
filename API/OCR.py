import pytesseract
from PIL import Image, ImageChops
from PIL import ImageEnhance
from PIL import ImageFilter
import matplotlib.pyplot as plt
import numpy as np
import scipy.signal as signal


def ocr(source):
    """
    调用ocr识别图像
    :param source: 图片路径
    :return: code:1-识别成功  0-识别失败
    """
    img = Image.open(source)
    width, height = img.size
    # 放大三倍
    # img = go_dark(img)
    # img.show()
    img = delete(img)
    # img.show()

    img = img.resize((width * 3, height * 3), Image.ANTIALIAS)
    # 灰度化
    img = img.convert('L')
    # 去除背景线条(实际上没去掉多少)

    # enh_sha = ImageEnhance.Sharpness(img)
    # sharpness = 3.0
    # image_sharped = enh_sha.enhance(sharpness)
    # img = image_sharped

    # img = depoint(img)
    # 获取边界
    # img.show()
    img = binarizing(img)
    # 二值化
    # img.show()
    # img = del_edge(img)
    # 截取边界 但是坏掉了
    # img.show()
    edge = pytesseract.image_to_boxes(img, lang="chi_sim")
    edge = edge.split('\n')
    for i in range(len(edge)):
        edge[i] = edge[i].split(' ')
    # 获取改变后的尺寸
    width, height = img.size
    region = (int(edge[0][1]) - 80, height - int(edge[0][4]) - 90, int(edge[0][3]) + width * 0.7,
              height - int(edge[len(edge) - 1][2]) + 50)
    # 裁切身份证号码图片
    img = img.crop(region)
    # img.show()
    res = pytesseract.image_to_string(img, lang="chi_sim")
    print(res)
    data = res.split('\n')
    # 删除无效行
    index = 0
    while True:
        if index >= len(data):
            break
        if data[index] == "":
            del data[index]
        index += 1

    name = ""
    gender = ""
    birthday = ""
    address = ""
    if len(data) >= 1:
        name = (data[0].split(' '))
        if len(name) >= 2:
            name = name[1]
        if len(data) >= 2:
            gender = (data[1].split(' '))
            if len(gender) >= 2:
                gender = gender[1]
            if len(data) >= 3:
                birthday = (data[2].split(' '))
                if len(birthday) >= 2:
                    birthday = birthday[1]
                if len(data) >= 4:
                    address = (data[3].split(' '))
                    if len(address) >= 2:
                        address = address[len(address) - 1]
                    if len(address) < 9:
                        address = ""

    return {"name": name, "gender": gender, "birthday": birthday, "address": address}


def delete(img):
    """
    反色相加
    :param img:
    :return:
    """
    img1 = img.copy()
    pixdata = img1.load()
    w, h = img1.size
    for x in range(w):
        for y in range(h):
            if pixdata[x, y][0] < 125 and pixdata[x, y][1] < 125 and pixdata[x, y][2] < 125:
                pixdata[x, y] = (255, 255, 255)
    img1 = ImageChops.invert(img1)
    return ImageChops.add(img, img1)


def del_edge(img):
    """
    清除边界
    :return:
    """
    pixdata = img.load()
    w, h = img.size
    top = 0
    left = 0
    right = w
    button = h
    list = []
    for x in range(w):
        for y in range(h):
            if pixdata[x, y] == 255:
                flag = True
                for right in range(20):
                    for deep in range(20):
                        if pixdata[x + right, y + deep] != 0 or pixdata[x - right, y - deep] != 255:
                            flag = False
                if flag:
                    list.append((x, y))
    print(list)
    box = (left, top, right, button)
    return img.crop(box)


def go_dark(img):
    pixdata = img.load()
    w, h = img.size
    r, g, b = img.split()
    plt.figure("lena")
    ar = np.array(r).flatten()
    plt.hist(ar, bins=256, normed=1, facecolor='r', edgecolor='r')
    ag = np.array(g).flatten()
    plt.hist(ag, bins=256, normed=1, facecolor='g', edgecolor='g')
    ab = np.array(b).flatten()
    plt.hist(ab, bins=256, normed=1, facecolor='b', edgecolor='b')
    plt.title('color')
    plt.show()

    r1 = 120
    r2 = 150
    b1 = 150
    b2 = 140

    for x in range(w):
        for y in range(h):
            if x <= w / 3 or y >= h / 3 * 2:
                if pixdata[x, y][0] < r1 and pixdata[x, y][2] > b1:
                    pixdata[x, y] = (0, 0, 0)
            elif x <= w / 3 * 2:
                if pixdata[x, y][0] < r2 and pixdata[x, y][2] > b2:
                    pixdata[x, y] = (0, 0, 0)

    r, g, b = img.split()
    plt.figure("lena")
    ar = np.array(r).flatten()
    plt.hist(ar, bins=256, normed=1, facecolor='r', edgecolor='r')
    ag = np.array(g).flatten()
    plt.hist(ag, bins=256, normed=1, facecolor='g', edgecolor='g')
    ab = np.array(b).flatten()
    plt.hist(ab, bins=256, normed=1, facecolor='b', edgecolor='b')
    plt.title('color')
    plt.show()

    return img


def depoint(img):
    pixdata = img.load()
    w, h = img.size
    for y in range(1, h - 1):
        for x in range(1, w - 1):
            count = 0
            if pixdata[x, y - 1] > 245:
                count = count + 1
            if pixdata[x, y + 1] > 245:
                count = count + 1
            if pixdata[x - 1, y] > 245:
                count = count + 1
            if pixdata[x + 1, y] > 245:
                count = count + 1
            if count > 2:
                pixdata[x, y] = 255
    return img


def binarizing(img, threshold):
    pixdata = img.load()
    w, h = img.size

    for y in range(h):
        for x in range(w):
            if pixdata[x, y] < threshold:
                pixdata[x, y] = 0
            else:
                pixdata[x, y] = 255
    return img


def binarizing(img):
    pixdata = img.load()
    w, h = img.size
    plt.figure()
    arr = np.array(img).flatten()
    plt.hist(arr, bins=256, normed=1, facecolor='green', alpha=0.75)
    plt.title('before')
    plt.show()
    for y in range(h):
        for x in range(w):
            if pixdata[x, y] < 125:
                pixdata[x, y] = 0
            else:
                pixdata[x, y] = 255
    arr = np.array(img).flatten()
    plt.hist(arr, bins=256, normed=1, facecolor='green', alpha=0.75)
    plt.title('after')
    plt.show()
    return img


if __name__ == '__main__':
    # ocr('test.png')
    ocr('./identity_card/3_back.jpg')
