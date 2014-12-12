class SagyoushijisController < ApplicationController
  before_action :set_sagyoushiji, only: [:show, :edit, :update, :destroy]

  # GET /sagyoushijis
  # GET /sagyoushijis.json
  def index
    @sagyoushijis = Sagyoushiji.all
  end

  # GET /sagyoushijis/1
  # GET /sagyoushijis/1.json
  def show
  respond_to do |format|
        format.html
        format.json { render json: @sagyoushiji}
        format.docx{send_data Sagyoushiji.docx(@sagyoushiji),type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',filename:"fuga.docx"}
        #format.docx {download_docx(@sagyoushiji),type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document;charset=shift_jis',filename:"fuga.docx"}
        #file = download_docx(@sagyoujishi)
        #format.docx {send_data file,type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document;charset=shift_jis',filename:"fuga.docx" }
   end
  end

  # GET /sagyoushijis/new
  def new
    @sagyoushiji = Sagyoushiji.new
  end

  # GET /sagyoushijis/1/edit
  def edit
  end

  # POST /sagyoushijis
  # POST /sagyoushijis.json
  def create
    @sagyoushiji = Sagyoushiji.new(sagyoushiji_params)

    respond_to do |format|
      if @sagyoushiji.save
        format.html { redirect_to @sagyoushiji, notice: 'Sagyoushiji was successfully created.' }
        format.json { render :show, status: :created, location: @sagyoushiji }
      else
        format.html { render :new }
        format.json { render json: @sagyoushiji.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sagyoushijis/1
  # PATCH/PUT /sagyoushijis/1.json
  def update
    respond_to do |format|
      if @sagyoushiji.update(sagyoushiji_params)
        format.html { redirect_to @sagyoushiji, notice: 'Sagyoushiji was successfully updated.' }
        format.json { render :show, status: :ok, location: @sagyoushiji }
      else
        format.html { render :edit }
        format.json { render json: @sagyoushiji.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sagyoushijis/1
  # DELETE /sagyoushijis/1.json
  def destroy
    @sagyoushiji.destroy
    respond_to do |format|
      format.html { redirect_to sagyoushijis_url, notice: 'Sagyoushiji was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
    #印刷
    def sagyoushijis_print
    end  
  
  def download_docx(sagyoushiji)
    input_file = "./tmp/template.docx"
    data = {
      key: "日本語でようこそ",
      hello: "hello world",
      students: [
        {name: "おぱ", score: 88},
        {name: "富夫", score: 50},
        {name: "久子", score: 40}
      ]
    }
    new_doc = DocxTemplater::DocxCreator.new(input_file, data)
    new_doc.generate_docx_file('./tmp/output.docx')

    return new_doc

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sagyoushiji
      @sagyoushiji = Sagyoushiji.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sagyoushiji_params
      params.require(:sagyoushiji).permit(:itakuhaken_id, :sagyouhoukoku_id, :atena, :sashidashi, :jisshinaiyou, :sumi, :nengetsu)
    end
    
end
