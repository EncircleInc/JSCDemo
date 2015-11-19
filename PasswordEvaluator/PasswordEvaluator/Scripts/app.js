(function(){
    var latestPassword;
    var updatePasswordInfo = _.debounce(function(){
                                        if(!latestPassword){
                                            return;
                                        }
                                        var result = zxcvbn(latestPassword);
                                        var score = result.score;
                                        var timeLabel = result.crack_times_display.offline_fast_hashing_1e10_per_second;
                                        var warningLabel = null;
                                        if(result.feedback){
                                            warningLabel = _.compact([result.feedback.warning].concat(result.feedback.suggestions)).join("\n");
                                        }
                                        nativePage.setPasswordStrengthInfo(score,timeLabel,warningLabel);
                                        },500);
    nativePage.setPasswordCallback(function(password){
                                   latestPassword = password;
                                   updatePasswordInfo();
                                   });
 })();
