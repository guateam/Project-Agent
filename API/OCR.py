import pytesseract
from PIL import Image
from PIL import ImageEnhance
from PIL import ImageFilter


def ocr(source):
    """
    调用ocr识别图像
    :param source: 图片路径
    :return: code:1-识别成功  0-识别失败
    """
    img = Image.open(source)
    width,height = img.size
    # 放大三倍
    img = img.resize((width * 3, height * 3), Image.ANTIALIAS)
    # 灰度化
    img = img.convert('L')
    # 去除背景线条(实际上没去掉多少)
    img = depoint(img)
    # 获取边界
    edge = pytesseract.image_to_boxes(img,lang="chi_sim")
    edge = edge.split('\n')
    for i in range(len(edge)):
        edge[i] = edge[i].split(' ')
    # 获取改变后的尺寸
    width, height = img.size
    region = (int(edge[0][1]) - 80, height - int(edge[0][4]) - 90, int(edge[0][3]) + width * 0.7,
              height - int(edge[len(edge)-1][2]) + 50)
    # 裁切身份证号码图片
    img = img.crop(region)

    img.show()
    res = pytesseract.image_to_string(img,lang="chi_sim")
    data = res.split('\n')
    # 删除无效行
    index = 0
    while True:
        if index >= len(data):
            break
        if data[index] == "" :
            del data[index]
        index+=1

    name = ""
    gender = ""
    birthday = ""
    address = ""
    if len(data)>= 1 :
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
                    birthday= birthday[1]
                if len(data) >= 4:
                    address = (data[3].split(' '))
                    if len(address) >= 2:
                        address= address[len(address)-1]
                    if len(address) < 9:
                        address = ""

    return {"name": name, "gender": gender, "birthday": birthday, "address": address}


def depoint(img):
    pixdata = img.load()
    w,h = img.size
    for y in range(1,h-1):
        for x in range(1,w-1):
            count = 0
            if pixdata[x,y-1] > 245:
                count = count + 1
            if pixdata[x,y+1] > 245:
                count = count + 1
            if pixdata[x-1,y] > 245:
                count = count + 1
            if pixdata[x+1,y] > 245:
                count = count + 1
            if count > 2:
                pixdata[x,y] = 255
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


if __name__ == '__main__':
    ocr('test.png')