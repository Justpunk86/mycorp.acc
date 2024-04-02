class EmpBonusDataController < ApplicationController
  before_action :get_ebd, only: %i[index create]

  def index
    @new_ebd = EmpBonusData.new()
  end

  def create
    emp_id = Employee.
           where(person_num: params[:emp_bonus_data][:person_num]).
           select("emp_id").first

    # y = params[:emp_bonus_data]["payment_date(1i)"]
    # m = params[:emp_bonus_data]["payment_date(2i)"]
    # d = params[:emp_bonus_data]["payment_date(3i)"]

    # payment_date = Date.new(y.to_i,m.to_i,d.to_i)

    @new_ebd = EmpBonusData.new(ebd_params)
    @new_ebd.emp_id = emp_id.id
    # @new_ebd.order_num = params[:emp_bonus_data][:order_num]
    # @new_ebd.payment_date = payment_date
    # @new_ebd.amount = params[:emp_bonus_data][:amount]

    if @new_ebd.valid?
      @new_ebd.save
      redirect_to emp_bonus_data_path
    else
      render action: 'index'
    end

  end

  def destroy
    ebd = EmpBonusData.where(
      "emp_id = ? and order_num = ?",
      params[:emp_id],
      params[:order_num]
      ).first
    ebd.delete

    redirect_to emp_bonus_data_path
  end

  private
  def get_ebd
    @ebd = EmpBonusData.
    joins("inner join employees on
            emp_bonus_data.emp_id = employees.emp_id"
        ).
            select("employees.emp_id",
                  "person_num",
                  "payment_date",
                  "order_num",
                  "amount")

  end

  def ebd_params

    params.require(:emp_bonus_data).
    permit(:emp_id,
      :payment_date,
      :order_num,
      :amount)
  end
end
