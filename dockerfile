FROM centos:centos7

WORKDIR /root
#install utility command
RUN yum -y update && \
	yum -y groupinstall "Development Tools" && \
	yum -y install epel-release wget sudo initscripts zip unzip gzip perl python3 gcc git nano bzip2 perl ncurses-devel SDL-devel zlib-devel git cmake clang xz-devel bzip2-devel python-devel 
RUN yum -y install python-pip
RUN pip install --upgrade pip

#install fastq-dump
RUN wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-centos_linux64.tar.gz && \
tar xf sratoolkit.current-centos_linux64.tar.gz && \
rm -f sratoolkit.current-centos_linux64.tar.gz  && \
ln -s /root/sratoolkit.2.10.8-centos_linux64/bin/fastq-dump /usr/bin/fastq-dump && \
ln -s /root/sratoolkit.2.10.8-centos_linux64/bin/vdb-config /usr/bin/vdb-config && \
ln -s /root/sratoolkit.2.10.8-centos_linux64/bin/prefetch /usr/bin/prefetch

#install bowtie2
WORKDIR /root
RUN wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.5/bowtie2-2.3.5-linux-x86_64.zip/download && \
mv download bowtie2.zip && \
unzip bowtie2.zip && \
rm -f bowtie2.zip && \
ln -s /root/bowtie2-2.3.5-linux-x86_64/bowties /usr/bin/bowtie2

#Download bowtie2 index
WORKDIR /root
RUN mkdir /root/bt2_index && \
wget ftp://ftp.ccb.jhu.edu/pub/data/bowtie2_indexes/hg19.zip && \
mv hg19.zip /root/bt2_index && \
cd /root/bt2_index && \
unzip /root/bt2_index/hg19.zip

#install samtools
WORKDIR /root
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
tar xf samtools-1.9.tar.bz2 && \
rm -f samtools-1.9.tar.bz2 && \
cd samtools-1.9 && \
./configure && \
make && \
make install && \
ln -s /root/samtools-1.9/samtools /usr/bin/samtools

#install macs
WORKDIR /root
RUN pip install numpy && \
pip install wheel && \
pip install MACS2==2.1.1.20160309

#install deeptools
WORKDIR /root
RUN pip install -U pip && \
    hash pip && \
    pip install setuptools && \
    pip install deeptools==3.3.0
