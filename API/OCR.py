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
    # 灰度化
    img = img.convert('L')
    # 以85阈值进行二值化
    # threshold = 85
    # table = []
    # for i in range(256):
    #     if i < threshold:
    #         table.append(0)
    #     else:
    #         table.append(1)
    # # 二值化
    # img = img.point(table, '1')
    # 显示图片，测试用，正式上线了注释掉
    #img.show()
    # 调用ocr识别
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
    return {"name":name,"gender":gender,"birthday":birthday,"address":address}