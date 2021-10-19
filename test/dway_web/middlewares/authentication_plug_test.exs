# defmodule DwayWeb.AuthenticationPlugTest do

#   use DwayWeb.ConnCase

#   setup do
#     {:ok, user} = Dway.Users.Accounts.call(%{email: "judite@d.com"})

#     conn =
#       put_req_header(
#         build_conn(),
#         "authentication",
#         user.id
#       )

#     [conn: conn]
#   end

#   describe "call/2" do
#       test "when de api token is valid, returns true" , %{conn: conn} do
#         conn

#       end
#   end

# end
