defmodule FoodDiaryWeb.SchemaTest do
  use FoodDiaryWeb.ConnCase, async: true
  use FoodDiaryWeb.SubscriptionCase

  alias FoodDiary.User
  alias FoodDiary.Users

  describe "users query" do
    test "When a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "mail@mail.com", name: "Mofo"}
      {:ok, %User{id: user_id}} = Users.Create.call(params)

      query = """
      {
          user(id: "#{user_id}"){
              name,
              email
          }
      }
      """

      expected_response = %{
        "data" => %{"user" => %{"email" => "mail@mail.com", "name" => "Mofo"}}
      }

      response =
        conn
        |> post("api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == expected_response
    end

    # test "When the user does not exist, returns an error", %{conn: conn} do
    #   query = """
    #   {
    #       user(id: "123456"){
    #           name,
    #           email
    #       }
    #   }
    #   """

    #   expected_response = %{
    #     "data" => %{"user" => nil},
    #     "errors" => [
    #       %{
    #         "locations" => [%{"column" => 5, "line" => 2}],
    #         "message" => "User not found",
    #         "path" => ["user"]
    #       }
    #     ]
    #   }

    #   response =
    #     conn
    #     |> post("api/graphql", %{query: query})
    #     |> json_response(:ok)

    #   assert response == expected_response
    # end
  end

  # describe "users mutation" do
  #   test "When all params are valid, creates user", %{conn: conn} do
  #     mutation = """
  #         mutation {
  #             createUser(input: {email: "mail@mail.com", name: "Hoje"}){
  #                 id,
  #                 name,
  #                 email
  #             }
  #         }
  #     """

  #     response =
  #       conn
  #       |> post("api/graphql", %{query: mutation})
  #       |> json_response(:ok)

  #     assert %{
  #              "data" => %{
  #                "createUser" => %{"email" => "mail@mail.com", "id" => _, "name" => "Hoje"}
  #              }
  #            } = response
  #   end
  # end

  # describe "subscriptions" do
  #   test "meals subscription", %{socket: socket} do
  #     params = %{email: "mail@mail.com", name: "Mofo"}
  #     {:ok, %User{id: user_id}} = Users.Create.call(params)

  #     mutation = """
  #       mutation {
  #         createMeal(input: {userId: "#{user_id}", description: "Pizza de calabresa", calories: 370.2, category: FOOD}){
  #           description,
  #           calories,
  #           category
  #         }
  #       }
  #     """

  #     subscription = """
  #       subscription {
  #         newMeal {
  #           descriptions
  #         }
  #       }
  #     """

  #     # setup da subscription
  #     socket_ref = push_doc(socket, subscription)
  #     assert_reply socket_ref, :ok, %{subscriptionId: subscription_id}

  #     # setup mutation
  #     socket_ref = push_doc(socket, mutation)
  #     assert_reply socket_ref, :ok, mutation_response

  #     expected_mutation_response == "ba"
  #     expected_subscription_response == "be"

  #     assert mutation_response == expected_mutation_response

  #     assert_push "subscription:data", subscription_response
  #     assert subscription_response == expected_subscription_response

  #   end
  # end
end
