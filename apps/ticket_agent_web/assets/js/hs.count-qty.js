/**
 * Count quantity wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSCountQty = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {maximum: 100},

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Count quantity wrapper.
     *
     * @param String selector (optional)
     * @param Object config (optional)
     *
     * @return jQuery pageCollection - collection of initialized items.
     */

    init: function (selector, config) {
      this.collection = selector && $(selector).length ? $(selector) : $();
      if (!$(selector).length) return;

      this.config = config && $.isPlainObject(config) ?
          $.extend({}, this._baseConfig, config) : this._baseConfig;

      this.config.itemSelector = selector;
      
      this.initCountQty(this.config);

      return this.pageCollection;

    },

    initCountQty: function (config) {
      //Variables
      var $self = this,
          collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
            $plus = $this.find('.js-plus'),
            $minus = $this.find('.js-minus'),
            $result = $this.find('.js-result'),
            resultVal = parseInt($result.val());

        $plus.on('click', function (e) {
          e.preventDefault();

          if (resultVal < config.maximum) {
            resultVal += 1;
          }
          $result.val(resultVal).trigger('change');
        });

        $minus.on('click', function (e) {
          e.preventDefault();

          if (resultVal >= 1) {
            resultVal -= 1;

            $result.val(resultVal).trigger('change');
          } else {
            return false;
          }
        });

        //Actions
        collection = collection.add($this);
      });
    }

  };

})(jQuery);
