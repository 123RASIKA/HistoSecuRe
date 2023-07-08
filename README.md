# HistoSecuRe

Secure Reversible data hiding using histogram Shifting

The project contains two matlab files , one is for embedding(encoder.m) for embedding the secret message in an image and other is for extracting(decoder.m) the message from an image.

steps to be followed:
->Open Matlab software and paste the encoder.m file.

->In imread("") function, write the name of the image.

->The encoder module will give the histogram of the original and embedded image , in which bit 1 is embedded at the peak point , the image after embedding and the PSNR of the embed image versus original image.

->Now after the embedding process, paste the decoder.m file.

->write the output stego image file name in ‘imread’ function in the code.

->The encoder module will give the extraction histogram and the image after extraction.

**put the image and the matlab files in the same folder**
