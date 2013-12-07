class VersionsController < ApplicationController
  def show
    @content_size = 100                                              #Obergrenze für Contentgröße in übersicht
    @chunk = Chunk.find(params[:chunk_id])                           #Chunk aus DB laden
    @book = Book.find(@chunk.book_id)                                #Buch aus DB laden
    if params[:entries].to_i > 0                                     #Wenn Übersichtseinträge größer null sind, dann nur gewählte Anzahl anzeigen
      @entries = [params[:entries].to_i,@chunk.versions.size].min    #wenn weniger Versionen als anzuzeigende Einträge vorhanden sind
    else
      @entries = @chunk.versions.size                                #sonst alle Versionen zeigen
    end
    unless params[:entries]                                          #wenn anzahl von einträgen nicht vorhanden ist (erster aufruf der seite)
      @entries = [10,@chunk.versions.size].min                       #standardmäßig auf 10 setzen oder nur so viele wie es Versionen gibt
    end
  end

  def revert_to_old_version                                          #Methode zum zurücksetzen der Version
    #@chunk.versions(params[:old_version_id]).reify.save!
    @chunk = Chunk.find(params[:id])                                 #Chunk aus DB laden
    @chunk.versions[params[:old_version_id].to_i].reify.save!        #Version aus versions-hash laden und als Aktuelle in DB speichern
    redirect_to  edit_book_chunk_path
  end

  def version                                                        #Methode zum Zeigen der Version
    @book = Book.find(params[:book_id])
    @chunk = Chunk.find(params[:chunk_id])
    @version = Version.find(params[:version_id])
  end

  def compare
    @book = Book.find(params[:book_id])
    @chunk = Chunk.find(params[:chunk_id])                               #Chunk laden
    if (params[:version1] == 'chunk')                                    #Wenn version1==parameter, dann
      @version1 = Chunk.find(params[:chunk_id]).content                  #aktuelle Version laden
    else                                                                 #sonst
      @version1 = @chunk.versions[params[:version1].to_i].reify.content  #die gewählte version laden
    end
    if (params[:version2]== 'chunk')                                     #analog zu Version2
      @version2 = Chunk.find(params[:chunk_id]).content
    else
      @version2 = @chunk.versions[params[:version2].to_i].reify.content
    end
  end

end
