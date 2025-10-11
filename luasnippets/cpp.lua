local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node


return {
  s("kyopro", {
    t({ "#include <bits/stdc++.h>",
        "using namespace std;",
        "typedef long long ll; typedef long double ld; typedef pair<ll,ll> pll; typedef vector<ll> vl; typedef vector<vl> vvl;",
        "#define REP(i,n) for(ll i=0;i<(ll)(n);i++)",
        "#define REPR(i,n) for(ll i=(ll)(n)-1;i>=0;i--)",
        "int main(int argc, char *argv[]) {",
        "  ios::sync_with_stdio(false);",
        "  cin.tie(0);",
        i(1, "Code!"),
        "  return 0;",
        "}" }),
  }
}
