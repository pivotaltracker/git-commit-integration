class RefsController < ApplicationController
  before_action :set_ref, only: [:show, :edit, :update, :destroy]
  before_action :set_commit, only: [:index]
  before_action :set_repo

  # GET /refs
  # GET /refs.json
  def index
    @refs = @commit ? @commit.refs : Ref.where(repo_id: @repo.id)
  end

  # GET /refs/1
  # GET /refs/1.json
  def show
  end

  # GET /refs/new
  def new
    @ref = @repo.refs.build
  end

  # GET /refs/1/edit
  def edit
  end

  # POST /refs
  # POST /refs.json
  def create
    @ref = @repo.refs.build(ref_params)

    respond_to do |format|
      if @ref.save
        format.html { redirect_to @ref, notice: 'Ref was successfully created.' }
        format.json { render :show, status: :created, location: @ref }
      else
        format.html { render :new }
        format.json { render json: @ref.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /refs/1
  # PATCH/PUT /refs/1.json
  def update
    respond_to do |format|
      if @ref.update(ref_params)
        format.html { redirect_to @ref, notice: 'Ref was successfully updated.' }
        format.json { render :show, status: :ok, location: @ref }
      else
        format.html { render :edit }
        format.json { render json: @ref.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /refs/1
  # DELETE /refs/1.json
  def destroy
    @ref.destroy
    respond_to do |format|
      format.html { redirect_to repo_refs_url(@repo), notice: 'Ref was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ref
    @ref = Ref.find(params[:id])
  end

  def set_commit
    @commit = Commit.find(params[:commit_id]) if params[:commit_id]
  end

  def set_repo
    @repo = Repo.find(params[:repo_id]) if params[:repo_id]
    @repo ||= @commit.repo if @commit
    @repo ||= @ref.repo.id
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ref_params
    params.require(:ref).permit(:reference, :repo_id)
  end
end
