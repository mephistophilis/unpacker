```bash
docker build --platform linux/amd64 -t unpacker:latest .
docker run --platform linux/amd64 -it --rm -v .:/root --name unpacker unpacker
docker run --platform linux/amd64 -it --rm -v .:/root --name unpacker unpacker ./extract.sh ./fw/SAMFW.COM_SM-S918B_MID_S918BXXS3BXAD_fac.zip

/Applications/Beyond\ Compare.app/Contents/MacOS/bcomp  @./diff.script ./fw/SAMFW.COM_SM-S918B_MID_S918BXXS3BXAD_fac/ap/super/system/ ./fw/SAMFW.COM_SM-S918B_TEL_S918BXXS3BXAD_fac/ap/super/system/ ./diff.txt
```