#!/bin/sh
touch /home/all.html
cat <<EOF > /home/all.html
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Untitled</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic&amp;display=swap">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css">
        <style type="text/css">
        .abang {
        background-color:Tomato;
        }
        .ijo {
        background-color:MediumSeaGreen;
        }
        #table_detail .hidden_row {
                        display: none;
        }
        .square {
    width: 60px;
        }
        </style>
</style>
</head>

<body><table class="table table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Address</th>
                <th>Status</th>
                <th>Node</th>
                <th>Mining</th>
                <th>Show More</th>
            </tr>
        </thead>
                <tbody>
EOF
while read line; do
cat <<EOF >> /home/all.html
                        <tr style="background-color:DodgerBlue;">
                                <td>User</td>
                <td colspan="4"><h3>$line</h3></td>
                        </tr>
EOF
while read line2; do
KOVET=$(netstat -netulp |grep 127.0.0.1:$line2 | awk -F "[ :]+" '/:/{print $5}')
if [[ $KOVET == $line2 ]]
then
DATC=$(curl -s "http://127.0.0.1:$line2/" -H 'Content-Type: application/json' --data "{\"method\":\"dna_identity\",\"params\":[],\"id\":1,\"key\":\"$line\"}")
states=$(echo $DATC | sed -n 's|.*"state":"\([^"]*\)".*|\1|p')
addrss=$(echo $DATC | sed -n 's|.*"address":"\([^"]*\)".*|\1|p')
age=$(echo $DATC | sed -n 's|.*"age":\([^"]*\),.*|\1|p')
add1=$(echo $addrss | head -c 3)
add2=$(echo $addrss | tail -c 3)
minir=$(echo $DATC | sed -n 's|.*"online":\([^"]*\),.*|\1|p')
IC=$(echo $DATC | sed -n 's|.*"invites":\([^"]*\),.*|\1|p')
BALC=$(curl -s "http://127.0.0.1:$line2/" -H 'Content-Type: application/json' --data "{\"method\":\"dna_getBalance\",\"params\":[\"$addrss\"],\"id\":1,\"key\":\"$line\"}")
stuck=$(echo $BALC | sed -n 's|.*"stake":"\([^"]*\)".*|\1|p')
wllt=$(echo $BALC | sed -n 's|.*"balance":"\([^"]*\)".*|\1|p')
if [[ $minir == true ]]
then
online="ON"
logon="✅"
else
online="OFF"
logon="⛔"
fi
cat <<EOF >> /home/all.html
                                <tr>
                                <td><a href="https://scan.idena.io/identity/$addrss" target="_blank">$add1...$add2</a></td>
                <td>$states</td>
                <td class="ijo"><h5>$line2</h5></td>
                <td>$online</td>
                <td><button onclick="showHideRow('hidden_row$line2');">show more</button></td>
                                </tr>
                                <tr id="table_detail" >
                                <td id="hidden_row$line2" class="hidden_row" colspan="5">
                                <table class="table table-striped" cellspacing="0" width="100%">
                                        <tbody>
                                                <tr>
                                                        <td rowspan="2" class="square" colspan="1"><img class="square" src="https://robohash.idena.io/$addrss"/></td>
                                                        <td colspan="4"><h5>$states</h5></td>
                                                </tr>
                                                <tr>
                                                        <td colspan="3">
                                                                $addrss
                                                        </td>
                                                        <td>Mining : $logon</td>
                                                </tr>
                                                <tr>
                                                        <td>Address :</td>
                                                        <td colspan="4"><a href="https://scan.idena.io/identity/$addrss" target="_blank">$addrss</a></td>
                                                </tr>
                                                <tr>
                                                        <td>Status :</td>
                                                        <td colspan="4">$states</td>
                                                </tr>
                                                <tr>
                                                        <td>Balance :</td>
                                                        <td colspan="4">$wllt</td>
                                                </tr>
                                                <tr>
                                                        <td>Stake :</td>
                                                        <td colspan="4">$stuck</td>
                                                </tr>
                                                <tr>
                                                        <td>Age : </td>
                                                        <td colspan="4">$age</td>
                                                </tr>
                                                <tr>
                                                        <td>Invite : </td>
                                                        <td cospan="4">$IC</td>
                                                </tr>
                                        </tbody>
                                </table>
                                </td>
                                </tr>
EOF
else
cat <<EOF >> /home/all.html
                                <tr>
                                        <td class="abang" colspan="1">Node</td>
                                        <td class="abang" colspan="2"><h5>$line2</h5></td>
                                        <td class="abang" colspan="2"><h4>OFF</h4></td>
                                </tr>
EOF
fi
done <<<$(cat /home/$line/$line-portRpc.txt)
done <<<$(cat /home/user.txt)
cat <<EOF >> /home/all.html
</tbody>
    </table>
        <script type="text/javascript">
                function showHideRow(row) {
                        \$("#" + row).toggle();
                }
        </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.min.js"></script>
</body>

</html>
EOF