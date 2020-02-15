def strip_commas_off_end(str)
  i = str.length - 1

  while (str[i] === ',')
    i -= 1
  end

  return str[0..i]
end
