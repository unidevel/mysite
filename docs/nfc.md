# 使用 Mac + Acs122u复制小区门禁卡

最近入手小米手环4NFC版，发现有个模拟门禁卡的功能，满心欢喜去按app中的向导操作，结果均显示不支持，无奈去网上搜索了一下，发现可以用pn532, ACR122U等NFC读写器来操作，就跑到闲鱼上花了70元买了一个ACR122U-A9，开始破解，因为手头只有mac，准备用windows的虚拟机，找了相关软件，竟然下载到了恶意软件。无视，结果虚拟机重启N次，果然恶意十足。换linux虚拟机，无奈识别仍有问题。只好继续搜mac相关的软件，终于功夫不负有心人，人品爆发模拟成功。

1. 安装官方驱动
2. brew install mfcuk mfoc ， 后来发现人品爆发，mfuck竟然没用上
3. 连上nfc，放上门卡，运行nfc-list，报错了
```
nfc-list uses libnfc 1.7.1
error	libnfc.driver.acr122_usb	Unable to claim USB interface (Permission denied)
nfc-list: ERROR: Unable to open NFC device: acr122_usb:020:002
```
4. 折腾了一番，发现连上ACR122U后需要执行一下下面两个命令（每次连接都要）
```
sudo launchctl stop com.apple.ifdreader
sudo launchctl remove com.apple.ifdreader
```
5. 然后再运行，ok了
6. 接着上mfoc碰运气 `mfoc -O card.dump` ，人品爆发很快就执行完了，生成card.dump
7. 运行 `xxd card.dump | head -1` 或者从第3步输出信息里面找到uid(前8个字节）
8. 找到一张UID或者CUID卡，放在读写器上，写入uid，`nfc-mfsetuid xxxxxxxx`
9. 那这张卡扔给小米手环去模拟，成功
10. 最好把小米手环放在读写器上，写入原卡信息，`nfc-mfclassic w a card.dump`
