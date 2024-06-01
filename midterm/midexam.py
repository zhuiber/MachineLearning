import matplotlib.pyplot as plt

# Example input data
individuals = [("Alice", 10), ("Bob", 15), ("Charlie", 8), ("David", 12), ("Eve", 5), ("Frank", 20), ("Grace", 3), ("Hannah", 25), ("Ivy", 18), ("Jack", 7)]

def calculate_distance(person1, person2):
    # Calculate the distance between two individuals based on their positions
    distance = abs(person1[1] - person2[1])
    return distance

def find_friends(individuals):
    friends_dict = {}
    
    for person1 in individuals:
        distances = []
        for person2 in individuals:
            if person1 != person2:
                distance = calculate_distance(person1, person2)
                distances.append((person2[0], distance))  # Store name and distance
                
        # Sort distances and select the 5 closest friends
        distances.sort(key=lambda x: x[1])
        friends = [distances[i][0] for i in range(min(5, len(distances)))]
        friends_dict[person1[0]] = friends
    
    return friends_dict

# Find friends for each individual
friends = find_friends(individuals)

# Plotting
plt.figure(figsize=(10, 6))
for person, position in individuals:
    plt.scatter(position, 0, label=person, marker='o')
    plt.text(position, 0, f'  {person}', verticalalignment='bottom', horizontalalignment='right')

plt.xlabel('Position on Number Axis')
plt.title('Individuals and Their Positions')
plt.grid(True)
plt.legend()
plt.show()

# Output the result
for person, friend_list in friends.items():
    print(f"{person}'s friends: {friend_list}")
