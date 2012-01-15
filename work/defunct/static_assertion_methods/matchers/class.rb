module Assay

  # Examples
  #
  #  "string".it IsLike[/string/i]
  #
  #  "string".it IsKind[String]
  #
  #  case 10.1
  #  when IsInstance[Fixnum]
  #  when IsWithin[0.2, 10]
  #  when IsMatch[/\d+\.\d+/]
  #  end
  #
  module IsClasses

    IsLike       = Assay::CompareFailure
    IsWithin     = Assay::DeltaFailure
    IsEqual      = Assay::EqualityFailure
    IsExecuted   = Assay::ExecutionFailure
    IsFalse      = Assay::FalseFailure
    IsIdentical  = Assay::IdentityFailure
    IsInstance   = Assay::InstanceFailure
    IsKind       = Assay::KindFailure
    IsMatch      = Assay::MatchFailure
    IsNil        = Assay::NilFailure
    IsRaised     = Assay::RaiseFailure
    IsResponsive = Assay::RespondFailure
    IsSame       = Assay::SameFailure
    IsThrown     = Assay::ThrowFailure
    IsTrue       = Assay::TrueFailure

  end

end

