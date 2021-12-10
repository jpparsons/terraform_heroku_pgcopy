package main

import (
	"flag"
	"fmt"
	"os/exec"
	"strings"
)

func main() {

	var (
		flgToApp    string
		flgFromApp  string
		flgBackupID string
		backupID    string
	)

	flag.StringVar(&flgToApp, "toApp", "", "Heroku restore to app name")
	flag.StringVar(&flgFromApp, "fromApp", "", "Heroku from DB backup app name")
	flag.StringVar(&flgBackupID, "backupID", "", "Optional DB backupID, defaults to last backup taken.")
	flag.Parse()

	// Heroku API does not support restore operations, only commandline
	// https://github.com/heroku/platform-api/issues/72
	fromApp := fmt.Sprintf("--app=%s", flgFromApp)

	if flgBackupID == "" {
		// get latest backup ID if one is not specified, this is NOT currently used
		// by the terraform restore as a DB backup ID is also the hostname
		backupsCMD := exec.Command("heroku", "pg:backups", fromApp)
		out, err := backupsCMD.CombinedOutput()
		must(err)

		// get latest database backup ID, it's on 3rd line of output
		backups := strings.Split(string(out), "\n")
		backupID := strings.Split(backups[3], " ")[0]
		fmt.Println(backupID)
	} else {
		backupID = flgBackupID
	}

	id := fmt.Sprintf("%s::%s", flgFromApp, backupID)
	app := fmt.Sprintf("--app=%s", flgToApp)
	appConfirm := fmt.Sprintf("--confirm=%s", flgToApp)

	fmt.Println("heroku", "pg:backups:restore", id, "DATABASE_URL", app, appConfirm)

	restoreCMD := exec.Command("heroku", "pg:backups:restore", id, "DATABASE_URL", app, appConfirm)
	out2, err2 := restoreCMD.CombinedOutput()
	fmt.Println(string(out2))
	must(err2)

}

func must(err error) {
	if err != nil {
		fmt.Printf("err: %s\n", err)
		panic(err)
	}
}
