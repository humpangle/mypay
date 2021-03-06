defmodule MyPay.MetaApiTest do
  use MyPay.DataCase

  alias MyPay.Meta.Api
  alias MyPay.Meta
  alias MyPay.Factory.Meta, as: Factory

  test "list/0 returns all metas" do
    meta = Factory.insert()
    assert Api.list() == [meta]
  end

  test "get/1 returns the meta with given id" do
    meta = Factory.insert()
    assert Api.get(meta.id) == meta
  end

  test "create_/1 with valid data creates a meta" do
    attrs = Factory.params()

    assert {:ok, %Meta{} = meta} = Api.create_(attrs)
    assert meta.break_time_secs == Map.get(attrs, :break_time_secs) || Api.default_break_time()
    assert meta.night_suppl_pay_pct == attrs.night_suppl_pay_pct
    assert meta.pay_per_hr == attrs.pay_per_hr
    assert meta.sunday_suppl_pay_pct == attrs.sunday_suppl_pay_pct
  end

  test "create_/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} =
             Factory.params(pay_per_hr: nil)
             |> Api.create_()
  end

  test "update_/2 with valid data updates the meta" do
    meta = Factory.insert()
    attrs = Factory.params()
    assert {:ok, meta} = Api.update_(meta, attrs)
    assert %Meta{} = meta
    assert meta.break_time_secs == Map.get(attrs, :break_time_secs) || Api.default_break_time()
    assert meta.night_suppl_pay_pct == attrs.night_suppl_pay_pct
    assert meta.pay_per_hr == attrs.pay_per_hr
    assert meta.sunday_suppl_pay_pct == attrs.sunday_suppl_pay_pct
  end

  test "update_/2 with invalid data returns error changeset" do
    meta = Factory.insert()

    assert {:error, %Ecto.Changeset{}} =
             Api.update_(
               meta,
               %{pay_per_hr: nil}
             )

    assert meta == Api.get(meta.id)
  end

  test "delete_/1 deletes the meta" do
    meta = Factory.insert()
    assert {:ok, %Meta{}} = Api.delete_(meta)
    assert Api.get(meta.id) == nil
  end

  test "change_/1 returns a meta changeset" do
    meta = Factory.insert()
    assert %Ecto.Changeset{} = Api.change_(meta)
  end

  test "get_latest/0 returns latest meta" do
    Factory.insert()
    meta = Factory.insert(break_time_secs: 50)
    latest = Api.get_latest()
    assert meta.id == latest.id
  end

  test "fields must be unique" do
    params = Factory.params(break_time_secs: 50)
    Factory.insert(params)
    msg = Meta.all_fields_uniqueness_error()

    assert {:error,
            %Ecto.Changeset{
              errors: [break_time_secs: {^msg, []}]
            }} = Api.create_(params)
  end
end
