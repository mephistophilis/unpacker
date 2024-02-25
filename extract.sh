#!/bin/bash

# 检查参数
if [ $# -ne 1 ]; then
  echo "Usage: extract.sh fw_zip_file"
  exit 1
fi

# 获取zip文件路径
fw_zip_file=$1

# 获取zip文件所在目录
fw_parent_dir=${fw_zip_file%/*}

# 获取zip文件名,不包含扩展名
fw_filename=${fw_zip_file##*/}
fw_filename=${fw_filename%.*}

# 从文件名获取解压目录名称     
fw_extract_dir=$fw_parent_dir/$fw_filename

# 新建解压目录
mkdir -p $fw_extract_dir

# 解压到目标目录  
unzip $fw_zip_file -d $fw_extract_dir

#################
cd $fw_extract_dir

ap_tar_file=$(find ./ -type f -name "AP_*")

# 从文件名中获取不包含扩展名的名称
ap_dir=ap

# 创建用来解压的目录
mkdir -p ./$ap_dir

# 用tar解压指定文件到目录
tar -xf $ap_tar_file -C ./$ap_dir

#################
cd $ap_dir

for ap_file in $(find ./ -type f -name "*.lz4"); do
  /root/otatools/bin/lz4 -d $ap_file
done

/root/otatools/bin/simg2img ./super.img ./super.img.raw

super_dir=./super
mkdir -p super

#查找super.img.raw文件
super_img_raw_file=$(find ./ -type f -name "super.img.raw") 

#使用lpunpack解压到super目录
/root/otatools/bin/lpunpack $super_img_raw_file $super_dir

cd $super_dir
# 查找super目录下所有img文件
all_super_imgs=$(find ./ -type f -name "*.img")

# 循环每个img文件
for img in $all_super_imgs; do

  # 获取img文件名
  img_filename=${img##*/}
  img_filename=${img_filename%.img}

  /root/bin/extract.erofs -i $img -x -o ./$img_filename
done