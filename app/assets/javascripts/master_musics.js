function masterMusicsLoader(){
  var score_decimal_level = [0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2];
  $(function(){
    $.ajax({
      url: 'master_musics/ajax_data',
      type: 'POST',
      dataType: 'json'
    }).done(function(data){
      console.log(data);
      var rank = 0, last_score = 999, i, j, name, tmp = [],
      music = data.music,
      score = data.score,
      users = data.users,
      games = data.games,
      sscores = data.total_sscores;
      for (i = 0; i < users.length; i++) {
        if (sscores[i] < last_score) rank++;
        tmp.push(['<tr><td>', rank, '</td><td>', users[i].name || users[i].account, '</td><td>', sscores[i].toFixed(1), '</td>'].join(''));
        for (j = 0; j < games.length; j++){
          tmp.push('<td>' + (score[i][j].standard_score).toFixed(1) + '</td>');
        }
        tmp.push('</tr>');
        last_score = sscores[i];
      }
      $('#standard-score table tbody').html(tmp.join(''));

    }).done(function(data){
      var rank = 1, last_score, i, j, name, tmp = [],
      music = data.music,
      score = data.score,
      users = data.users,
      games = data.games,
      sscores = data.total_sscores,
      averages = data.averages;

      for (i = 0; i < users.length; i++) {
        if (sscores[i] < last_score) rank++;      
        tmp.push(['<tr><td>', rank, '</td><td>', users[i].name || users[i].account, '</td>'].join(''));
        for (j = 0; j < games.length; j++){
          tmp.push(['<td><a href ="', score[i][j].url, '">', score[i][j].score.toFixed(score_decimal_level[j]), '</a></td>'].join(''));
        }
        tmp.push('</tr>');
        last_score = sscores[i];
      }

      tmp.push('<tr><td> - </td><td>平均</td>');
      for (i = 0; i < averages.length; i++){
        tmp.push('<td>' + averages[i].toFixed(score_decimal_level[i]) + '</td>');
      }
      tmp.push('</tr>');

      $('#score table tbody').html(tmp.join(''));
    });
  });
}
