from flask import Flask, request, jsonify
import steganography as stg
import base64
import os


RECEIVED_EFILEPATH = '../images/to_encrypt.png'
RECEIVED_DFILEPATH = '../images/to_decrypt.png'
ENCRYPTED_FILEPATH = '../images/encrypted.png'

if not os.path.isdir('../images'):
    os.mkdir('../images')

app = Flask(__name__)

@app.route('/encrypt', methods=['GET','POST'])
def encrypt():
    if request.method == 'POST':
        data = request.get_json(force=True)
        image_data = data['image']
        msg_to_embed = data['msg']

        with open(RECEIVED_EFILEPATH, 'wb') as bin_file:
            bin_file.write(base64.b64decode(image_data))

        stg.encrypt(RECEIVED_EFILEPATH, msg_to_embed)
        os.remove(RECEIVED_EFILEPATH)
        print('Message Embedded!')

    with open(ENCRYPTED_FILEPATH, 'rb') as bin_file:
        img = bin_file.read()
        print('Response Ready')
        # print(base64.b64encode(img).decode())

    return jsonify({'img': base64.b64encode(img).decode()})

@app.route('/decrypt', methods=['GET', 'POST'])
def decrypt():
    decrypted_msg = ''

    if request.method == 'POST':
        data = request.get_json(force=True)
        image_data = data['image']

        with open(RECEIVED_DFILEPATH, 'wb') as bin_file:
            bin_file.write(base64.b64decode(image_data))

        decrypted_msg = stg.decrypt(RECEIVED_DFILEPATH)
        # os.remove(RECEIVED_DFILEPATH)

    print('Decrypted!')
    print(decrypted_msg)
    return jsonify({'decrypted_msg': decrypted_msg})

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
