defmodule MyPayWeb.Query.Shift do
  alias MyPayWeb.Query.Meta, as: MetaQuery

  def all_fields_fragment do
    name = "ShiftAllFieldsFragment"

    fragment = """
      fragment #{name} on Shift {
        id
        _id
        date
        startTime
        endTime
        hoursGross
        normalHours
        nightHours
        sundayHours
        normalPay
        nightSupplPay
        sundaySupplPay
        totalPay

        insertedAt
        updatedAt
      }
    """

    {name, fragment}
  end

  def query_all do
    {frag_name, frag} = all_fields_fragment()
    {meta_frag_name, meta_frag} = MetaQuery.all_fields_fragment()

    query = """
      shifts(shift: $shift) {
        ...#{frag_name}

        meta {
          ...#{meta_frag_name}
        }
      }
    """

    parameters = "$shift: GetShiftInput"
    fragments = ~s( #{frag} #{meta_frag} )

    %{
      query: query,
      fragments: fragments,
      parameters: parameters
    }
  end

  def create_shift do
    {frag_name, frag} = all_fields_fragment()

    """
    mutation CreateShift($shift: CreateShiftInput!) {
      shift(shift: $shift) {
        ...#{frag_name}
      }
    }

    #{frag}
    """
  end
end
