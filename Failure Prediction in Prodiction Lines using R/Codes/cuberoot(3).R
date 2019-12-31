train_numeric_S0_2<-train_numeric_S0
for (i in 3:ncol(train_numeric_S0_2)) {
  for (j in 1:nrow(train_numeric_S0_2))
  {
    x<-train_numeric_S0_2[j,i]
    if(is.na(x))
    {
      next
    }
    if (x<0)
    {
      x1=(x)^(1/3)
    }
    if (x>0)
    {
      x1=(x)^(1/3)
    }
    train_numeric_S0_2[j,i] <- x1
  }
}
