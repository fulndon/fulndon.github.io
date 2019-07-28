<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.authoricon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

<script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<span id="busuanzi_container_site_pv"> {{ __('busuanzi.click')}} <span id="busuanzi_value_site_pv"></span>{{ __('busuanzi.click_unit')}}</span> | 
<span id="busuanzi_container_site_pv"> {{ __('busuanzi.user')}} <span id="busuanzi_value_site_uv"></span>{{ __('busuanzi.user_unit')}}</span>

