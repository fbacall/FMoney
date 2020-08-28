class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_transactions, only: [:index]
  before_action :set_pagination, only: [:index]

  # GET /transactions
  # GET /transactions.json
  def index
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    raise 'no'
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.fetch(:transaction, {})
  end

  def set_transactions
    if params[:source_id]
      @source = Source.find(params[:source_id])
      @transactions = @source.transactions
    else
      @transactions = Transaction.all
    end
  end

  def set_pagination
    if params[:month]
      first_day = Date.parse("#{params[:month]}-01")
      last_day = (first_day >> 1) - 1
      @transactions = @transactions.order(date: :desc).where(date: first_day..last_day).page(1).per(99999)
    else
      @page = params[:page]&.to_i || 1
      @per_page = params[:per_page]&.to_i || 30
      @max_page = @transactions.count / @per_page
      @transactions = @transactions.order(date: :desc).page(@page).per(@per_page)
    end
  end
end
