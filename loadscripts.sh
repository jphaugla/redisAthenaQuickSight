cut -d '|' -f1,2 data/nation.tbl | sed -e 's/|/ "/' | sed -e 's/$/"/' | sed -e 's/^/nation-/' | sed -e 's/^/SET /' > data/redis.data
cat data/redis.data | redis-cli -c -h redis-12000.athena.jph.demo-rlec.redislabs.com -p 12000
cat data/active_orders.data | redis-cli -c -h redis-12000.athena.jph.demo-rlec.redislabs.com -p 12000
