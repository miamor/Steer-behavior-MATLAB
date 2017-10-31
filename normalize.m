function norm = normalize(A)
  mag_ = mag(A);
  if (any(mag_)) % mag != 0
    A = A/mag_;
  end
  norm = A;
end