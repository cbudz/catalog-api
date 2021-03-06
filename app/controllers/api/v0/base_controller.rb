module Api
  module V0
    class BaseController < ApplicationController
      rescue_from Catalog::TopologyError, :with => :topology_service_error

      def list_order_item
        render :json => Order.find(params.require(:order_id)).order_items.find(params.require(:order_item_id))
      end

      def list_order_items
        render :json => Order.find(params.require(:order_id)).order_items
      end

      def list_orders
        render :json => Order.all
      end

      def list_portfolios
        render :json => Portfolio.all
      end

      def list_portfolio_items
        render :json => PortfolioItem.kept
      end

      def fetch_portfolio_with_id
        render :json => Portfolio.find(params.require(:portfolio_id))
      end

      def fetch_portfolio_item_from_portfolio
        item = Portfolio.find(params.require(:portfolio_id))
                        .portfolio_items.find(params.require(:portfolio_item_id))
        render :json => item
      end

      def fetch_portfolio_items_with_portfolio
        render :json => Portfolio.find(params.require(:portfolio_id)).portfolio_items
      end

      def fetch_portfolio_item_with_id
        render :json => PortfolioItem.find(params.require(:portfolio_item_id))
      end

      def list_progress_messages
        render :json => OrderItem.find(params.require(:order_item_id)).progress_messages
      end

      def new_order
        render :json => Order.create
      end

      def submit_order
        so = Catalog::SubmitOrder.new(params.require(:order_id))
        render :json => so.process.order
      end

      def fetch_plans_with_portfolio_item_id
        so = Catalog::ServicePlans.new(params.require(:portfolio_item_id))
        render :json => so.process.items
      end

      def fetch_provider_control_parameters
        so = Catalog::ProviderControlParameters.new(params.require(:portfolio_item_id))
        render :json => so.process.data
      end
    end
  end
end
