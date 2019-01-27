import random

from PIL import ImageFont, Image, ImageDraw


def generate(x):
    """
    随机生成一组身份证号码与其他信息
    :return:
    """
    area = [[]]
    street = []
    second_name = []
    first_name = []
    nationality_list = []
    with open('area.txt', encoding='utf-8') as file:
        for line in file.readlines():
            line.replace('\n', '')
            if line == ',\n':
                area.append([])
            else:
                data = line.split(' ')
                area[len(area) - 1].append(data)

    with open('street.txt', encoding='utf-8') as file:
        for line in file.readlines():
            street.append(line)

    with open('second_name.txt', encoding='utf-8') as file:
        for line in file.readlines():
            for value in line.split(' '):
                second_name.append(value)

    with open('family_name.txt', encoding='utf-8') as file:
        for line in file.readlines():
            first_name.append(line)

    with open('nationality.txt', encoding='utf-8') as file:
        line = file.readline()
        nationality_list = line.split(' ')
        nationality_list[len(nationality_list) - 1] = nationality_list[len(nationality_list) - 1].replace('\n', '')

    with open('./output/output.txt', 'w', encoding='utf-8') as file:
        for i in range(x):
            print('----------------------------')
            first = random.randint(0, len(area) - 1)
            second = random.randint(0, len(area[first]) - 1)
            first_address = area[first][0]
            address = first_address[1]
            temp = ''
            if second != 0:
                temp = area[first][second][1]
            if area[first][second][0][-2:] != '00':
                for value in area[first]:
                    code = area[first][second][0][0:4] + '00'
                    if value[0] == code:
                        address += value[1]
            address += temp
            address = address.replace('\n', '')
            address += street[random.randint(0, len(street) - 1)].replace('\n', '') + str(random.randint(0, 999)) + '号'
            number = str(area[first][second][0])
            year = random.randint(1970, 2019)
            month = random.randint(1, 12)
            day = 0
            big = [1, 3, 5, 7, 8, 10, 12]
            if month in big:
                day = random.randint(1, 31)
            elif month == 2:
                if (year % 4 == 0 and year % 100 != 0) or year % 400 == 0:
                    day = random.randint(1, 29)
                else:
                    day = random.randint(1, 28)
            else:
                day = random.randint(1, 30)
            if month < 10:
                month = '0' + str(month)
            if day < 10:
                day = '0' + str(day)
            number = number + str(year) + str(month) + str(day)

            random_code = random.randint(0, 9999)
            gender = '男'
            if random_code % 2 == 0:
                gender = '女'
            if random_code < 10:
                random_code = '000' + str(random_code)
            elif random_code < 100:
                random_code = '00' + str(random_code)
            elif random_code < 1000:
                random_code = '0' + str(random_code)
            else:
                random_code = str(random_code)
            number = number + random_code
            weight = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
            number_list = list(number)
            count = 0
            for j in range(len(weight)):
                count += int(number_list[j]) * weight[j]
            count = count % 11
            if count == 10:
                count = 'X'
            number = number + str(count)

            name = first_name[random.randint(0, len(first_name) - 1)] + ' ' + second_name[
                random.randint(0, len(second_name) - 1)]

            nationality = nationality_list[random.randint(0, len(nationality_list) - 1)]
            print('姓名：' + str(name.replace('\n', '')))
            print('性别：' + str(gender) + ' 民族：' + nationality)
            print('地址：' + str(address))
            print('身份证号码：' + number)
            print_pic(name, gender, nationality, number, address, year, month, day)
            file.write(name.replace('\n', '').replace(' ', '') + ' ' + gender + ' ' + nationality + ' ' + str(
                year) + ' ' + str(int(month)) + ' ' + str(int(day)) + ' ' + address.replace('\n',
                                                                                            '') + ' ' + number + '\n')


def print_pic(name, gender, nationality, number, address, year, month, day):
    tip_tff = './font/simhei.ttf'
    name_tff = './font/STHeiti.ttf'
    number_tff = './font/OCR-B 10 BT.ttf'
    birthday_tff = './font/fz-v4.0.TTF'
    tip_font = ImageFont.truetype(tip_tff, 30)
    name_font = ImageFont.truetype(name_tff, 45)
    birthday_font = ImageFont.truetype(birthday_tff, 33)
    other_font = ImageFont.truetype(name_tff, 33)
    number_font = ImageFont.truetype(number_tff, 45)
    img = Image.open('back_blank.jpg')
    draw = ImageDraw.Draw(img)
    draw.text((100, 150), '姓 名', fill=(90, 180, 210), font=tip_font)
    draw.text((100, 230), '性 别', fill=(90, 180, 210), font=tip_font)
    draw.text((100, 310), '出 生', fill=(90, 180, 210), font=tip_font)
    draw.text((100, 390), '地 址', fill=(90, 180, 210), font=tip_font)
    draw.text((100, 570), '公民身份证号码', fill=(90, 180, 210), font=tip_font)
    draw.text((320, 230), '名 族', fill=(90, 180, 210), font=tip_font)
    draw.text((320, 310), '年', fill=(90, 180, 210), font=tip_font)
    draw.text((410, 310), '月', fill=(90, 180, 210), font=tip_font)
    draw.text((500, 310), '日', fill=(90, 180, 210), font=tip_font)
    draw.text((200, 140), name.replace('\n', ''), fill=(0, 0, 0), font=name_font)
    draw.text((200, 230), gender, fill=(0, 0, 0), font=other_font)
    draw.text((410, 230), nationality, fill=(0, 0, 0), font=other_font)
    draw.text((200, 310), str(year), fill=(0, 0, 0), font=birthday_font)
    if int(month) < 10:
        draw.text((370, 310), str(int(month)), fill=(0, 0, 0), font=birthday_font)
    else:
        draw.text((360, 310), str(int(month)), fill=(0, 0, 0), font=birthday_font)
    if int(day) < 10:
        draw.text((460, 310), str(int(day)), fill=(0, 0, 0), font=birthday_font)
    else:
        draw.text((450, 310), str(int(day)), fill=(0, 0, 0), font=birthday_font)
    if len(address) > 11:
        count = 0
        step = 0
        while count < len(address):
            address_list = address[count:count + 11]
            l_step = 0
            for value in address_list:
                draw.text((200 + l_step, 390 + step * 40), value, fill=(0, 0, 0), font=other_font)
                l_step += 36
            count += 11
            step += 1
    else:
        draw.text((200, 390), address, fill=(0, 0, 0), font=other_font)
    number_list = list(number)
    step = 0
    for value in number_list:
        draw.text((360 + step, 570), value, fill=(0, 0, 0), font=number_font)
        step += 30
    # img.show()
    img.save('./output/' + name.replace('\n', '').replace(' ', '') + '_' + number + '.jpg', 'jpeg')


if __name__ == '__main__':
    generate(100)
