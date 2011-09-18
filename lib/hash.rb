class Hash
  # From active_support/core_ext/hash/diff
  def detailed_diff(old_hash)
    added = dup.delete_if { |k, v| old_hash[k] == v }
    removed = old_hash.dup.delete_if { |k, v| has_key?(k) }
    result = {}
    result[:added] = added unless added.empty?
    result[:removed] = removed unless removed.empty?
    result
  end
end

