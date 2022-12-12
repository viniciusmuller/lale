defmodule Lale.RequestsTest do
  use Lale.DataCase

  alias Lale.Requests

  describe "requests" do
    alias Lale.Requests.Request

    import Lale.RequestsFixtures

    @invalid_attrs %{timestamp: nil}

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert Requests.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert Requests.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      valid_attrs = %{timestamp: ~U[2022-12-11 17:13:00Z]}

      assert {:ok, %Request{} = request} = Requests.create_request(valid_attrs)
      assert request.timestamp == ~U[2022-12-11 17:13:00Z]
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Requests.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      update_attrs = %{timestamp: ~U[2022-12-12 17:13:00Z]}

      assert {:ok, %Request{} = request} = Requests.update_request(request, update_attrs)
      assert request.timestamp == ~U[2022-12-12 17:13:00Z]
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = Requests.update_request(request, @invalid_attrs)
      assert request == Requests.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = Requests.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> Requests.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = Requests.change_request(request)
    end
  end
end
