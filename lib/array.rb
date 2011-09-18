class Array

  def diff(other)
    result = {}
    added = self - other
    removed = other - self
    result[:added] = added unless added.empty?
    result[:removed] = removed unless removed.empty?
    result
  end

  # Largest range with different subsequence
  def range_with_diff_subseq(other)
    self_size = self.size
    other_size = other.size

    low = 0
    max_pos = self_size < other_size ? self_size : other_size
    # trim beginning with the same value
    while low < max_pos and self[low] == other[low]
      low += 1
    end

    high = -1
    max_pos = -max_pos
    # trim end with the same value
    while high > max_pos and self[high] == other[high]
      high -= 1
    end

    # the two arrays within this range contain different values
    (low..high)
  end

  def seq_diff(other)
    added = []; removed = []
    trimmed_range = self.range_with_diff_subseq other
    trimmed_self = self[trimmed_range]
    trimmed_other = other[trimmed_range]

    self_size = trimmed_self.size
    other_size = trimmed_other.size
    self_i = 0; other_i = 0

    while self_i < self_size and other_i < other_size
      if trimmed_self[self_i] == trimmed_other[other_i]
        self_i += 1; other_i += 1
      elsif trimmed_self[self_i] < trimmed_other[other_i]
        added << trimmed_self[self_i]
        self_i += 1
      else
        removed << trimmed_other[other_i]
        other_i += 1
      end
    end

    if other_i == other_size
      sub_self = trimmed_self[self_i...self_size]
      added.concat sub_self unless sub_self.empty?
    end

    if self_i == self_size
      sub_other = trimmed_other[other_i...other_size]
      removed.concat sub_other unless sub_other.empty?
    end
    result = {}
    result[:added] = added unless added.empty?
    result[:removed] = removed unless removed.empty?
    result
  end

end

