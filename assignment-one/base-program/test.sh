gcc *.c
echo Linear Data Size 5000
echo ./a.out 5000
./a.out 1000 4
rm ../report.linear.txt | true
cp ./report.linear.txt ../report.linear.txt | true
