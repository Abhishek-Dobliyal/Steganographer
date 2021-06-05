# Required Imports
from PIL import Image # pip install Pillow

ENCRYPTED_IMAGE_PATH = '../images/encrypted.png'
TO_DECRYPT_IMGPATH = '../images/to_decrypt.png'

def generate_binary(data):
    ''' Returns a binary value of each
    element in data '''
    res = [format(ord(i), '08b') for i in data]
    return res

def modify_pixels(pixels, data):

    data_array = generate_binary(data)
    img_data = iter(pixels)

    for i in range(len(data_array)):
        pix = [value for value in img_data.__next__()[:3] +
                                img_data.__next__()[:3] +
                                img_data.__next__()[:3]]

        # Pixel value should be made
        # odd for 1 and even for 0
        for j in range(8):
            if (data_array[i][j] == '0' and pix[j] & 1 != 0):
                pix[j] -= 1

            elif (data_array[i][j] == '1' and pix[j] & 1 == 0):
                if pix[j] != 0:
                    pix[j] -= 1
                else:
                    pix[j] += 1

        if i == len(data_array) - 1:
            if pix[-1] & 1 == 0:
                if pix[-1] != 0:
                    pix[-1] -= 1
                else:
                    pix[-1] += 1

        else:
            if pix[-1] & 1 != 0:
                pix[-1] -= 1

        pix = tuple(pix)
        yield pix[0:3]
        yield pix[3:6]
        yield pix[6:9]

def modify_img(new_img, data):
    ''' Modifies the pixels of the img'''
    width = new_img.size[0]
    (x, y) = (0, 0)

    for pixel in modify_pixels(new_img.getdata(), data):

        # Putting modified pixels in the new image
        new_img.putpixel((x, y), pixel)
        if x == width - 1:
            x = 0
            y += 1
        else:
            x += 1

def encrypt(img_path, msg_to_embed):
    ''' Embeds the message into the image '''
    image = Image.open(img_path, 'r')

    if len(msg_to_embed) == 0:
        raise ValueError('Msg is empty!')

    new_img = image.copy()
    modify_img(new_img, msg_to_embed)

    new_img.convert('RGB').save(ENCRYPTED_IMAGE_PATH)

def decrypt(img_path):
    ''' Fetches the message from the encrypted image '''
    image = Image.open(img_path, 'r')

    msg = ''
    img_data = iter(image.getdata())

    while True:
        pixels = [value for value in img_data.__next__()[:3] +
                                img_data.__next__()[:3] +
                                img_data.__next__()[:3]]

        binary = ''.join('0' if i & 1 == 0 else '1' for i in pixels[:9])
        print(binary)

        msg += chr(int(binary, 2))

        if pixels[-1] & 1 != 0:
            return msg

