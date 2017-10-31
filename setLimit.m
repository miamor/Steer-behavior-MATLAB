function limit = setLimit(A, max)
  magSq_ = magSq(A);
  if magSq_ > max*max
    mag = sqrt(magSq_);
    A(1) = (A(1)*max)/mag;
    A(2) = (A(2)*max)/mag;
    A(3) = (A(3)*max)/mag;
  end
  limit = A;
end