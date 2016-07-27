#for a given dictionary, map the key into a description
# if no dictionary key is passed ('ei_bsbu_m_r2'), then we have back a function
# if a dictionar key is passed ('ei_bsbu_m_r2', 'BS-CCI-BAL'), we shall get back a string
eus.dic.get.description = function(dic.name, key=NULL){
  dic = eus.dic.load(dic.name)
  f = function(k){
    dic[k,]$description
  }
  if(is.null(key)){
    f
  }else{
    f(key)
  }

}
