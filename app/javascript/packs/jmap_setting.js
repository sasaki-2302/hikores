$(document).on('turbolinks:load', function() {
  $(document).ready(function() {
    $('#jmap').jmap({
      width: '100%',
      height: '450px',
      showTextShadow: true,
      dividerColor: '#EFE4A6',
      showPrefectureName: true,
      showRoundedPrefecture: true,
      prefectureNameType: 'full',
      prefectureBackgroundColor: '#62B34C',
      prefectureBackgroundHoverColor: '#95A834',
      prefectureLineColor: '#EFE4A6',
      prefectureLineHoverColor: '#ffffff',
      prefectureLineWidth: '2px',
      prefectureLineGap: '0px',
      prefectureInnerLineWidth: '1px',
      prefectureInnerLineColor: '#EFE4A6',
      prefectureInnerLineType: 'outset',
      prefectureRadius: '15px',
      prefectureLineY: '2px',
      prefectureLineX: '2px',
      fontSize: '0.6rem',
      fontColor: '#fff',
      onSelect : function(e,data){
        location.href = "/search?prefecture_id="+(data.code);
      }
    });
  });
});