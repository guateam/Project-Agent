import jieba

def similar(a,b):
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



if __name__ == "__main__":
    simi = similar("番茄炒蛋", "西红柿炒蛋")
    print(simi)