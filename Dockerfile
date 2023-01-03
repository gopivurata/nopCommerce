#mkdir /Nop
#sudo apt update
#apt install wget unzip -y
#cd /Nop
#wget "https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip"
#unzip /Nop/nopCommerce_4.50.3_NoSource_linux_x64.zip
#rm /Nop/nopCommerce_4.50.3_NoSource_linux_x64.zip
#port 80
#CMD ["dotnet","/Nop/Nop.Web.dll"]
#stage-1
FROM ubuntu:20.04 as unzip
RUN apt update && \
    apt install wget unzip -y && \
    mkdir /Nop && \
    cd /Nop && \
    wget "https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip" && \
    unzip /Nop/nopCommerce_4.50.3_NoSource_linux_x64.zip && \
    rm /Nop/nopCommerce_4.50.3_NoSource_linux_x64.zip

#stage-2
FROM mcr.microsoft.com/dotnet/runtime:6.0
LABEL app="nopCommerce"
LABEL owner="gopi"
COPY --from=unzip /Nop /Nop
WORKDIR /Nop
RUN mkdir /Nop/bin && mkdir /Nop/logs
EXPOSE 80
RUN chmod 777 /Nop/bin
RUN chmod 777 /Nop/logs
CMD ["dotnet","/Nop/Nop.Web.dll"]
~                                  
