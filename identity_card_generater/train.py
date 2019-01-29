def rewrite():
    """
    覆盖box的char文件
    :return:
    """
    box_path = './output/id.normal.exp0.box'
    char_path = './output/box.txt'
    save_path = './box/id.normal.exp0.box'
    with open(box_path, 'r', encoding='utf-8') as box:
        with open(char_path, 'r', encoding='utf-8') as char_list:
            with open(save_path, 'w', encoding='utf-8') as save_file:
                for value in box.readlines():
                    char = char_list.readline()
                    box_list = value.split(' ')
                    save_file.write(
                        char.replace('\n', '') + ' ' + box_list[1] + ' ' + box_list[2] + ' ' + box_list[3] + ' ' +
                        box_list[
                            4] + ' ' + box_list[5])


def sort():
    txt_path = './output/output.txt'
    out_path = './box/box.txt'
    with open(txt_path, 'r', encoding='utf-8') as file:
        with open(out_path, 'w', encoding='utf-8') as write:
            data = []
            for value in file.readlines():
                value = value.replace('\n', '')
                value_list = value.split(' ')
                tag = ['姓名', '性别', '名族', '出生', '年', '月', '日', '地址', '公民身份证号码']
                text = tag[0] + value_list[0] + tag[1] + value_list[1] + tag[2] + value_list[2] + tag[3] + value_list[
                    3] + tag[4] + value_list[4] + tag[5] + value_list[5] + tag[6] + tag[7] + value_list[6] + tag[8] + \
                       value_list[7]
                data.append(list(text))
            data = sorted(data, key=lambda x: str(x))
            for value in data:
                for char in value:
                    write.write(char + '\n')


if __name__ == '__main__':
    rewrite()
