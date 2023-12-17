ls  /home/data_share/ydj/Rawdata1/*/*gz|wc
mv  /home/data_share/ydj/Rawdata1/*/*gz /home/data_share/ydj/rawdata1/
cd /home/data_share/ydj/rawdata1
find ./ -type f -not -name "*.txt" -print0 | xargs -0 md5sum > file1.txt
md5sum -c file1.txt

ls ./|grep gz|awk -F '_' '{print $1}'|uniq|awk -F '_' '{print $1"\t"$1"\tExome"}' >sample1.txt

time nohup perl /home/wu_lab/Pipeline/src/job_sub.pl -raw /home/data_share/ydj/rawdata1/sample_R?.fq.gz -n /home/data_share/ydj/rawdata1/sample1.txt -o /home/data_share/ydj/result1 -pc 1110

##核心脚本的位置/home/wu_lab/Pipeline/src
#记得自己过一遍代码! 记得移动cvf文件
cp /home/data_share/ydj/result1/*/gatk/*.indel.vcf  /home/data_share/ydj/finish1/INDEL
cp /home/data_share/ydj/result1/*/gatk/*.snp.vcf  /home/data_share/ydj/finish1/SNP

chmod -R +x  /home/data_share/ydj/finish1
for i in `find /home/data_share/ydj/finish1/SNP -name "*.snp.vcf" |sort` ;do name=`basename $i ".snp.vcf"` ;perl /home/wu_lab/Tools/ANNOVAR/auto_ANNOVAR2017_du.pl -i /home/data_share/ydj/finish1/SNP/${name}.snp.vcf -o /home/data_share/ydj/finish1/SNP_marker/${name}.snp --inhouse --hgmd --extreme --remove --vcf >all.snp.log 2>&1 ;echo $name;done;


for i in `find /home/data_share/ydj/finish1/SNP -name "*.snp.vcf" |sort` ;do name=`basename $i ".snp.vcf"` ;cp /home/data_share/ydj/finish1/SNP_marker/${name}.snp.marker.xls /home/data_share/ydj/finish1/SNP_result/;done;

for i in `find /home/data_share/ydj/finish1/SNP -name "*.snp.vcf" |sort` ;do name=`basename $i ".snp.vcf"` ;cp /home/data_share/ydj/finish1/SNP_marker/${name}.snp.marker.xls /home/data_share/ydj/marker/202311/snp/;done;

for i in `find /home/data_share/ydj/finish1/INDEL -name "*.indel.vcf" |sort` ;do name=`basename $i ".indel.vcf"` ;perl /home/wu_lab/Tools/ANNOVAR/auto_ANNOVAR2017_du.pl -i /home/data_share/ydj/finish1/INDEL/${name}.indel.vcf  -o /home/data_share/ydj/finish1/INDEL_marker/${name}.indel --inhouse --hgmd --extreme --remove --vcf >all.indel.log 2>&1 ;echo $name;done;


for i in `find /home/data_share/ydj/finish1/INDEL -name "*.indel.vcf" |sort` ;do name=`basename $i ".indel.vcf"` ;cp /home/data_share/ydj/finish1/INDEL_marker/${name}.indel.marker.xls /home/data_share/ydj/finish1/INDEL_result/;done;

for i in `find /home/data_share/ydj/finish1/INDEL -name "*.indel.vcf" |sort` ;do name=`basename $i ".indel.vcf"` ;cp /home/data_share/ydj/finish1/INDEL_marker/${name}.indel.marker.xls /home/data_share/ydj/marker/202311/indel;done;

rm -rf /home/data_share/ydj/result1/*   /home/data_share/ydj/rawdata1/*  /home/data_share/ydj/finish1/SNP_result/*  /home/data_share/ydj/finish1/SNP/*   /home/data_share/ydj/finish1/INDEL_result/*  /home/data_share/ydj/finish1/INDEL/*




# progress log
