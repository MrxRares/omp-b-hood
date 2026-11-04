

stock getIPToInt(const string:ip[16],x=-1,new_bit=0) { while(ip[++x]) new_bit += ip[x]!='.'?ip[x]-'0':0; return new_bit; }