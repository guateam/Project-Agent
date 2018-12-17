import os

import jieba


def jieba_text():
    # jieba.set_dictionary('./jieba_dict/dict.txt.big')  # 字典
    # jieba.enable_parallel(4)  # 使用4进程运行
    stop_word_path='./jieba_dict/stopwords.txt'
    input_path='./wiki_text/wiki_zh_cn_text.txt'
    output_path='./wiki_text/wiki_jieba_text.txt'

    if not os.path.exists(stop_word_path):
        print('需求停用词文件不存在！')
        exit()
    if not os.path.exists(input_path):
        print('需求分词文件不存在！')
        exit()

    stop_word_set = set()  # 停用词
    with open(stop_word_path, 'r', encoding='utf-8') as stopwords:
        for stop_word in stopwords:
            stop_word_set.add(stop_word.strip('\n'))

    with open(output_path, 'w', encoding='utf-8') as output:
        with open(input_path, 'r', encoding='utf-8') as input:
            for texts_num, line in enumerate(input):
                line = line.strip('\n')
                words = jieba.cut(line, cut_all=False)
                for word in words:
                    if word not in stop_word_set:
                        output.write(word + ' ')
                output.write('\n')

                if (texts_num + 1) % 1000 == 0:
                    print('已处理 ' + str(texts_num + 1) + ' 行断句')


if __name__ == "__main__":
    jieba_text()
