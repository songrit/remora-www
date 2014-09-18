class TradesController < ApplicationController
  # DELETE /trades/1
  # DELETE /trades/1.json
  def destroy
    @trade = Trade.find(params[:id])
    @trade.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
