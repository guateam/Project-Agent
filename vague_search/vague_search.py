import jieba


def count_word(content):
    """
    计算文本的词语数量
    :param content: 文本
    :return: 词语数量
    """
    # 标点符号
    punctuation = ",./?;\'[]()\"\\!<>，。？“”：；:！"
    # 停用词
    stopword = "的了呢啊哦地得了"
    # 用jieba将两个句子分词，获得迭代器
    a_word = jieba.cut(content, cut_all=False)
    word_collection = []
    # 获取词语集合
    for word in a_word:
        if word not in punctuation and word not in stopword:
            word_collection.append(word)
    return len(word_collection)


def count_contain(content,word):
    """
    计算文本中包含多少个特定词语
    :param content: 文本
    :param word: 特定词语
    :return: 数量
    """
    # 标点符号
    punctuation = ",./?;\'[]()\"\\!<>，。？“”：；:！"
    # 停用词
    stopword = "的了呢啊哦地得了在是"
    # 用jieba将两个句子分词，获得迭代器
    a_word = jieba.cut(content, cut_all=False)
    # 计数器
    count = 0
    for wd in a_word:
        if wd not in punctuation and wd not in stopword:
            if wd == word:
                count += 1

    return count


def compute_tf(word,content):
    # 标点符号
    punctuation = ",./?;\'[]()\"\\!<>，。？“”：；:！"
    # 停用词
    stopword = "的了呢啊哦地得了"
    # 用jieba将两个句子分词，获得迭代器
    a_word = jieba.cut(content, cut_all=False)
    # 筛选后的词语数组
    word_collection = []
    # 计数器
    count_all = 0
    count_certain = 0
    # 获取词语集合
    for wd in a_word:
        if wd not in punctuation and wd not in stopword:
            # 总词语数增加
            count_all += 1
            if wd == word:
                # 特定词语数增加
                count_certain += 1
    # 计算tf值
    tf = count_all/count_certain
    return tf


def similar(a, b):
    """
    计算两个字符串的余弦相似度
    :param a: 第一个字符串
    :param b: 第二个字符串
    :return: (float)相似度 -1完全相反   0相互无关   1完全相同
    """
    # 标点符号
    punctuation =",./?;\'[]()\"\\!<>，。？“”：；:！"
    # 停用词
    stopword = "的了呢啊哦地得了"
    # 用jieba将两个句子分词，获得迭代器
    a_word = jieba.cut(a, cut_all=False)
    b_word = jieba.cut(b, cut_all=False)
    # 用于存放分词后的词语
    array_a = []
    array_b = []
    # 用于存放公共的词语集合
    word_collection = set()
    # 获取公共词语集合，并且获取两个句子包含的词语
    for word in a_word:
        if word not in punctuation and word not in stopword:
            word_collection.add(word)
            array_a.append(word)
    for word in b_word:
        if word not in punctuation and word not in stopword:
            word_collection.add(word)
            array_b.append(word)
    # 用于存放向量
    a_vec = []
    b_vec = []
    # 计算向量每个元素的值，值为词语集合中的词语在该句子中出现的次数
    for collection in word_collection:
        count_a = 0
        count_b = 0
        for word in array_a:
            if collection == word:
                count_a+=1
        for word in array_b:
            if collection == word:
                count_b+=1
        a_vec.append(count_a)
        b_vec.append(count_b)
    # 余弦相似度的分子up  分母的两个部分down_a和down_b
    up = 0
    down_a = 0
    down_b = 0
    # 计算分子分母的值
    for i in range(len(a_vec)):
        up+=a_vec[i]*b_vec[i]
        down_a+=a_vec[i]**2
        down_b+=b_vec[i]**2
    # 分母取平方根然后将两部分相乘
    down_a = down_a**0.5
    down_b = down_b**0.5
    down = down_a * down_b
    # 计算余弦相似度，-1意味着两个向量指向的方向正好截然相反，1表示它们的指向是完全相同的，
    # 0通常表示它们之间是独立的，而在这之间的值则表示中间的相似性或相异性。
    cos_similarity = up/down
    return cos_similarity


def get_reg(input):
    """
    根据输入的字符串生成模糊匹配的正则表达式
    :param input: 输入的字符串
    :return: 正则表达式
    """
    reg = ''
    for single in input:
        reg += '(.*)'+single
    reg += '(.*)'
    return reg


def select_by_similarity(input, word_bank, similarity=-1,key="content"):
    """
    计算输入的字符串和输入的待比较字符串数组的相似度，然后按照相似度降序排列，剔除相似度小于边界similarity的数据
    :param input: 输入的字符串
    :param word_bank: 待比较的字符串数组
    :param similarity: 边界相似度
    :param key: 用于比较的文本内容的键名
    :return:
    """
    data = []
    output = []
    # 计算数组内每一个字符串和输入的相似度
    for i in range(len(word_bank)):
        similarity = similar(input, word_bank[i][key])
        # 若有time字段表示搜索次数，则将其加入返回的内容中
        if word_bank[i].has_key('time'):
            data.append({'content': word_bank[i][key], 'similarity': similarity, 'time': word_bank[i]['time']})
        else:
            data.append({'content': word_bank[i][key], 'similarity': similarity})

    # 若有处理好的数据，则根据相似度或搜索次数降序排列
    if len(data) > 0:
        data.sort(key=lambda it: it['similarity'], reverse=True)
        if data[0]['similarity'] <= 0 and data[0].has_key('time'):
            data.sort(key=lambda it: it['time'],reverse=True)

    # 剔除小于边界的数据
    for it in data:
        if it['similarity'] >= similarity:
            output.append(it)
    return output


if __name__ == "__main__":
    simi = similar("番茄炒蛋", "西红柿炒蛋")
    print(simi)