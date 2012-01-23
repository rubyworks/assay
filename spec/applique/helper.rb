
# Very simple helper assertion system, so we can test
# Assay without name clashes.

def assert(truth, msg=nil, trace=nil)
  if truth
    increment_counts(:pass)
  else
    increment_counts(:fail)
    raise Assertion, msg || "assert failed", trace || caller
  end
end

def refute(truth)
  assert(!truth, "refute failed", caller)
end

def expect(error)
  counts = $ASSERTION_COUNTS.dup
  begin
    yield
    $ASSERTION_COUNTS = counts
    increment_counts(:fail)
    raise Assertion, "#{error} not raised.", caller
  rescue error
    $ASSERTION_COUNTS = counts
    increment_counts(:pass)
  end
end

def increment_counts(which)
  case which
  when :pass
    $ASSERTION_COUNTS[:pass] += 1
  when :fail
    $ASSERTION_COUNTS[:fail] += 1
  end
  $ASSERTION_COUNTS[:total] += 1
end

