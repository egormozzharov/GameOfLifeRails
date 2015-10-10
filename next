
[1mFrom:[0m /home/egor/Rails/Best/app/controllers/users_controller.rb @ line 16 UsersController#save_email:

    [1;34m15[0m: [32mdef[0m [1;34msave_email[0m
 => [1;34m16[0m:   binding.pry
    [1;34m17[0m: 
    [1;34m18[0m:   [32mif[0m params[[33m:user[0m] && params[[33m:user[0m][[33m:email[0m]
    [1;34m19[0m:     current_user.email = params[[33m:user[0m][[33m:email[0m]
    [1;34m20[0m:     current_user.skip_reconfirmation! [1;30m# don't forget this if using Devise confirmable[0m
    [1;34m21[0m:     respond_to [32mdo[0m |format|
    [1;34m22[0m:       [32mif[0m current_user.save
    [1;34m23[0m:         binding.pry
    [1;34m24[0m:         format.html { redirect_to current_user, [35mnotice[0m: [31m[1;31m'[0m[31mYour email address was successfully updated.[1;31m'[0m[31m[0m }
    [1;34m25[0m:         format.json { head [33m:no_content[0m }
    [1;34m26[0m:       [32melse[0m
    [1;34m27[0m:         binding.pry
    [1;34m28[0m:         format.html { @show_errors = [1;36mtrue[0m }
    [1;34m29[0m:         format.json { render [35mjson[0m: @user.errors, [35mstatus[0m: [33m:unprocessable_entity[0m }
    [1;34m30[0m:       [32mend[0m
    [1;34m31[0m:     [32mend[0m
    [1;34m32[0m: [32mend[0m
    [1;34m33[0m: 
    [1;34m34[0m:   binding.pry
    [1;34m35[0m: [32mend[0m

