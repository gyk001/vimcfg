#! /bin/sh
if  test  "$USER"  = root; then  
wget http://ftp.mozilla.org/pub/mozilla.org/js/js-1.7.0.tar.gz -O- | tar xvz   
cd js/src  
make -f Makefile.ref  
mkdir -p /usr/include/smjs/ -v  
cp *.{h,tbl} /usr/include/smjs/ -v  
cd Linux_All_DBG.OBJ  
cp *.h /usr/include/smjs/ -v  
mkdir -p /usr/local/{bin,lib}/ -v  
cp js /usr/local/bin/ -v  
cp libjs.so /usr/local/lib/ -v 
                                    else   
                                        echo "You must be root. Try sudo $0"  
                                    fi  
