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
    redirect_to  edit_book_chunk_path                                #Weiterleitung zum bearbeiten des neuen Chunks
  end

  def version                                                        #Methode zum Zeigen der Version
    @book = Book.find(params[:book_id])
    @chunk = Chunk.find(params[:chunk_id])
    @version = ''                                                    #@Version initialisieren
    if (! params[:version_id] == 0 )                                 #Prüft ob es sich um den aktuellen Chunk oder eine Version handelt
      @version = Version.find(params[:version_id]).reify.content     #Version
    else
      @version = Chunk.find(params[:chunk_id]).content               #Chunk
    end

  end

  def compare
    @book = Book.find(params[:book_id])                              #Book aus DB laden
    @choice = {}                                                     #Array für ausgewählte Versionen
    i = 0
    params.each do |p|                                               #Params durchsuchen nach keys, die mit 'vers' beginen
      if p[0][0..3].eql?('vers')                                     #wenn 'vers'-key gefunden wurde
        @choice[i] = p[1]                                            #speichern des zugehörigen values
        i = i + 1
      end
    end

    @chunk = Chunk.find(params[:chunk_id])                           #Chunk laden
    if (@choice[0] == '0')                                           #Wenn version1==parameter, dann
      @version1 = Chunk.find(params[:chunk_id]).content              #aktuelle Version laden
    else                                                             #sonst
      @version1 = @chunk.versions[@choice[0].to_i].reify.content     #die gewählte version laden
    end
    if (@choice[1] == '0')                                           #analog zu Version2
      @version2 = Chunk.find(params[:chunk_id]).content
    else
      @version2 = @chunk.versions[@choice[1].to_i].reify.content
    end
  end

end
