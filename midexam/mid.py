def find_friends(individuals):
    # 根据位置对个体进行排序
    individuals.sort(key=lambda x: x[1])

    # 字典，用于存储每个个体的朋友
    friends_map = {}

    # 遍历每个个体
    for i in range(len(individuals)):
        current_individual = individuals[i][0]
        friends = []

        # 记录当前个体的位置
        current_position = individuals[i][1]

        # 记录距离当前个体最近的五个朋友
        closest_friends = []

        # 遍历所有个体，找到最接近的五个朋友
        for j in range(len(individuals)):
            if individuals[j][0] != current_individual:  # 排除当前个体本身
                friend_position = individuals[j][1]
                distance = abs(current_position - friend_position)

                # 如果当前朋友列表还不足五个，或者当前朋友更接近，则添加到最近朋友列表中
                if len(closest_friends) < 5:
                    closest_friends.append((individuals[j][0], distance))
                    closest_friends.sort(key=lambda x: x[1])
                elif distance < closest_friends[-1][1]:
                    closest_friends[-1] = (individuals[j][0], distance)
                    closest_friends.sort(key=lambda x: x[1])

        # 提取最近朋友列表中的姓名和距离
        for friend, distance in closest_friends:
            friends.append((friend, distance))
        friends_map[current_individual] = friends

    return friends_map


individuals = [("Alice", 10), ("Bob", 5), ("Charlie", 8), ("David", 15), ("Lily", 6), ("Chao", 9), ("Lin", 7), ("Linda", 10), ("Xixi", 12), ("Shiyu",20), ("Tong",23), ("Liu", 33)]
friends = find_friends(individuals)
for person, friend_list in friends.items():
    print(f"{person}的朋友:")
    for friend, distance in friend_list:
        print(f"    {friend} (距离: {distance})")