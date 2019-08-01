import random

def main():
    result = random.randint(0, 1)
    response = "{ \"result\" : "+str(result)+" }"
    print(response)

if __name__=="__main__":
    main()