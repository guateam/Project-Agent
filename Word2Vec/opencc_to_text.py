from opencc import OpenCC


def opencc_to_text():
    cc = OpenCC('t2s')

    with open('./wiki_text/wiki_text.txt', 'r', encoding='utf-8') as input:
        with open('./wiki_text/wiki_zh_cn_text.txt', 'w', encoding='utf-8') as output:
            num = 0;
            for value in input.readlines():
                num += 1;
                line = cc.convert(value)
                output.write(line)
                if num % 1000 == 0:
                    print("处理了 " + str(num) + ' 篇文章')


if __name__ == "__main__":
    opencc_to_text()
