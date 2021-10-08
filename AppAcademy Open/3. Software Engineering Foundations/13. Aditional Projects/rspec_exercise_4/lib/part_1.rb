## PART 1
def my_reject(arr, &prc)
  new_arr = []
  arr.each { |ele| new_arr << ele unless prc.call(ele) }
  new_arr
end

def my_one?(arr, &prc)
  arr.count(&prc) == 1
end

def hash_select(hash, &prc)
  new_hash = {}
  hash.each { |k, v| new_hash[k] = v if prc.call(k, v) }
  new_hash
end

def xor_select(arr, prc1, prc2)
  # new_arr = []
  # arr.each { |ele| new_arr << ele if prc1.call(ele) ^ prc2.call(ele) }
  # new_arr
  arr.select { |ele| prc1.call(ele) ^ prc2.call(ele) }
end

def proc_count(val, procs)
  truth_count = 0
  procs.each { |prc| truth_count += 1 if prc.call(val) }
  truth_count
end
